/*
 * Copyright (C) 2008 The Android Open Source Project
 * Copyright (C) 2017 The M.A.D. Team
 * Copyright (C) 2018 MoYsTeR
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


#define LOG_TAG "lights"

#include <cutils/log.h>
#include <stdint.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <fcntl.h>
#include <pthread.h>
#include <time.h>
#include <stdlib.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <hardware/lights.h>

static pthread_once_t g_init = PTHREAD_ONCE_INIT;
static pthread_mutex_t g_lock = PTHREAD_MUTEX_INITIALIZER;

static int g_attention;
static struct light_state_t g_battery;
static struct light_state_t g_notification;

static int g_backlight = 255;

/* INFINIX LED */
char const *const INFINIX_LED_FILE = "/sys/class/leds/button-backlight/brightness";
char const *const INFINIX_TRIGGER_FILE = "/sys/class/leds/button-backlight/trigger";

char const *const INFINIX_DELAY_ON_FILE = "/sys/class/leds/button-backlight/delay_on";
char const *const INFINIX_DELAY_OFF_FILE = "/sys/class/leds/button-backlight/delay_off";

/* Red LED */
char const*const RED_LED_FILE
        = "/sys/class/leds/red/brightness";

char const*const RED_TRIGGER_FILE
        = "/sys/devices/platform/1100f000.i2c/i2c-5/5-0034/rt5081_pmu_rgbled/leds/red/trigger";

char const*const RED_DELAY_ON_FILE
        = "/sys/devices/platform/1100f000.i2c/i2c-5/5-0034/rt5081_pmu_rgbled/leds/red/delay_on";

char const*const RED_DELAY_OFF_FILE
        = "/sys/devices/platform/1100f000.i2c/i2c-5/5-0034/rt5081_pmu_rgbled/leds/red/delay_off";

/* Green LED */
char const*const GREEN_LED_FILE
        = "/sys/class/leds/green/brightness";

char const*const GREEN_TRIGGER_FILE
        = "/sys/devices/platform/1100f000.i2c/i2c-5/5-0034/rt5081_pmu_rgbled/leds/green/trigger";

char const*const GREEN_DELAY_ON_FILE
        = "/sys/devices/platform/1100f000.i2c/i2c-5/5-0034/rt5081_pmu_rgbled/leds/green/delay_on";

char const*const GREEN_DELAY_OFF_FILE
        = "/sys/devices/platform/1100f000.i2c/i2c-5/5-0034/rt5081_pmu_rgbled/leds/green/delay_off";

/* BLUE LED */
char const*const BLUE_LED_FILE
        = "/sys/class/leds/blue/brightness";

char const*const BLUE_TRIGGER_FILE
        = "/sys/devices/platform/1100f000.i2c/i2c-5/5-0034/rt5081_pmu_rgbled/leds/blue/trigger";

char const*const BLUE_DELAY_ON_FILE
        = "/sys/devices/platform/1100f000.i2c/i2c-5/5-0034/rt5081_pmu_rgbled/leds/blue/delay_on";

char const*const BLUE_DELAY_OFF_FILE
        = "/sys/devices/platform/1100f000.i2c/i2c-5/5-0034/rt5081_pmu_rgbled/leds/blue/delay_off";

/* BACKLIGHT */
char const *const LCD_FILE = "/sys/class/leds/lcd-backlight/brightness";

/* device methods */
void init_globals(void)
{
    /* init the mutex */
    pthread_mutex_init(&g_lock, NULL);
}

static int write_int(char const *path, int value)
{
    int fd;

    fd = open(path, O_RDWR);
    if (fd >= 0) {
	char buffer[20];
	int bytes = snprintf(buffer, sizeof(buffer), "%d\n", value);
	ssize_t amt = write(fd, buffer, (size_t)bytes);

	close(fd);
	return amt == -1 ? -errno : 0;
    } else {
	return -errno;
    }
}

static int write_str(char const *path, char *str)
{
    int fd;

    fd = open(path, O_WRONLY);
    if (fd >= 0) {
	char buffer[20];
	int bytes = snprintf(buffer, sizeof(buffer), "%s", str);
	ssize_t amt = write(fd, buffer, (size_t)bytes);

	close(fd);
	return amt == -1 ? -errno : 0;
    } else {
	return -errno;
    }
}

static int is_lit(struct light_state_t const *state)
{
    return state->color & 0x00ffffff;
}

static int INFINIX_blink(int level, int onMS, int offMS)
{
	static int preStatus; /* 0: off, 1: blink, 2: no blink */
	int nowStatus;
	int i = 0;

	if (level == 0)
		nowStatus = 0;
	else if (onMS && offMS)
		nowStatus = 1;
	else
		nowStatus = 2;

	if (preStatus == nowStatus)
		return -1;

	if (nowStatus == 0)
		write_int(INFINIX_LED_FILE, 0);
	else if (nowStatus == 1) {
		write_str(INFINIX_TRIGGER_FILE, "timer");
		while (((access(INFINIX_DELAY_OFF_FILE, F_OK) == -1) ||
			(access(INFINIX_DELAY_OFF_FILE, R_OK|W_OK) == -1)) && i < 10) {
			i++;
		}
		write_int(INFINIX_DELAY_OFF_FILE, offMS);
		write_int(INFINIX_DELAY_ON_FILE, onMS);
	} else {
		write_str(INFINIX_TRIGGER_FILE, "none");
		write_int(INFINIX_LED_FILE, 255); /* default full brightness */
	}
	preStatus = nowStatus;
	return 0;
}

static int rgb_to_brightness(struct light_state_t const *state)
{
    int color = state->color & 0x00ffffff;

    return ((77*((color>>16)&0x00ff))
	    + (150*((color>>8)&0x00ff)) + (29*(color&0x00ff))) >> 8;
}

static int set_light_backlight(struct light_device_t *dev,
			       struct light_state_t const *state)
{
    if (!dev)
	return -1;

    int err = 0;
    int brightness = rgb_to_brightness(state);

    pthread_mutex_lock(&g_lock);
    err = write_int(LCD_FILE, brightness);
    pthread_mutex_unlock(&g_lock);
    return err;
}

static int set_speaker_light_locked(struct light_device_t *dev,
				    struct light_state_t const *state)
{
    int len;
    int alpha, red, green;
    int onMS, offMS;
    unsigned int colorRGB;

    switch (state->flashMode) {
	case LIGHT_FLASH_TIMED:
	    onMS = state->flashOnMS;
	    offMS = state->flashOffMS;
	    break;
	case LIGHT_FLASH_NONE:
	default:
	    onMS = 0;
	    offMS = 0;
	    break;
    }

    colorRGB = state->color;

    alpha = (colorRGB >> 24) & 0xFF;
    if (alpha) {
	red = (colorRGB >> 16) & 0xFF;
	green = (colorRGB >> 8) & 0xFF;
    } else { /* alpha = 0 means turn the LED off */
	red = green = 0;
    }

    if (red)
	   INFINIX_blink(red, onMS, offMS);
    else if (green)
	INFINIX_blink(green, onMS, offMS);
    else
	INFINIX_blink(0, 0, 0);

    return 0;
}

static void handle_speaker_battery_locked(struct light_device_t *dev)
{
    if (is_lit(&g_battery)) {
	set_speaker_light_locked(dev, &g_battery);
    } else {
	set_speaker_light_locked(dev, &g_battery); /* Turkey workaround: notification and Low battery case, IPO bootup, NLED cannot blink */
	set_speaker_light_locked(dev, &g_notification);
    }
}

static int set_light_battery(struct light_device_t *dev,
			     struct light_state_t const *state)
{
    pthread_mutex_lock(&g_lock);
    g_battery = *state;

    handle_speaker_battery_locked(dev);
    pthread_mutex_unlock(&g_lock);
    return 0;
}

static int set_light_notifications(struct light_device_t *dev,
				   struct light_state_t const *state)
{
    pthread_mutex_lock(&g_lock);
    g_notification = *state;

    handle_speaker_battery_locked(dev);
    pthread_mutex_unlock(&g_lock);
    return 0;
}

static int set_light_attention(struct light_device_t *dev,
			       struct light_state_t const *state)
{
    pthread_mutex_lock(&g_lock);
    if (state->flashMode == LIGHT_FLASH_HARDWARE)
	g_attention = state->flashOnMS;
    else if (state->flashMode == LIGHT_FLASH_NONE)
	g_attention = 0;
    pthread_mutex_unlock(&g_lock);
    return 0;
}

/* Close the lights device */
static int close_lights(struct light_device_t *dev)
{
    if (dev) {
	free(dev);
    }
    return 0;
}

/* module methods */
/* Open a new instance of a lights device using name */
static int open_lights(const struct hw_module_t *module, char const *name,
		       struct hw_device_t **device)
{
    int (*set_light)(struct light_device_t *dev,
	    struct light_state_t const *state);

    if (strcmp(LIGHT_ID_BACKLIGHT, name) == 0)
	set_light = set_light_backlight;
    else if (strcmp(LIGHT_ID_NOTIFICATIONS, name) == 0)
	set_light = set_light_notifications;
    else if (strcmp(LIGHT_ID_ATTENTION, name) == 0)
	set_light = set_light_attention;
    else
	return -EINVAL;

    pthread_once(&g_init, init_globals);

    struct light_device_t *dev = malloc(sizeof(struct light_device_t));

    if (!dev)
	return -ENOMEM;

    memset(dev, 0, sizeof(*dev));

    dev->common.tag = HARDWARE_DEVICE_TAG;
    dev->common.version = 0;
    dev->common.module = (struct hw_module_t *)module;
    dev->common.close = (int (*)(struct hw_device_t *))close_lights;
    dev->set_light = set_light;

    *device = (struct hw_device_t *)dev;
    return 0;
}

static struct hw_module_methods_t lights_module_methods = {
    .open = open_lights,
};

/* The lights Module */
struct hw_module_t HAL_MODULE_INFO_SYM = {
    .tag = HARDWARE_MODULE_TAG,
    .version_major = 1,
    .version_minor = 0,
    .id = LIGHTS_HARDWARE_MODULE_ID,
    .name = "INFINIX Lights Module",
    .author = "MediaTek",
	.methods = &lights_module_methods,
};
