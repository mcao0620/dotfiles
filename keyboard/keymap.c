/*
Copyright 2019 @foostan
Copyright 2020 Drashna Jaelre <@drashna>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include QMK_KEYBOARD_H
#include "features/custom_shift_keys.h"

// const custom_shift_key_t custom_shift_keys[] = {
//   {KC_EXLM , KC_EXLM},
//   {KC_MINS , KC_MINS},
//   {KC_PLUS , KC_PLUS},
//   {KC_BSLS , KC_BSLS},
//   {KC_EQL  ,  KC_EQL},
// };

const custom_shift_key_t custom_shift_keys[] = {
  {KC_EXLM , KC_EXLM},
  {KC_MINS , KC_MINS},
  {KC_PLUS , KC_PLUS},
  {KC_BSLS , KC_BSLS},
  {KC_EQL  ,  KC_EQL},
  {KC_COMM , KC_UNDS},
  {KC_DOT  , KC_MINS},
};
uint8_t NUM_CUSTOM_SHIFT_KEYS =
    sizeof(custom_shift_keys) / sizeof(custom_shift_key_t);

bool process_record_user(uint16_t keycode, keyrecord_t* record) {
  if (!process_custom_shift_keys(keycode, record)) { return false; }
  return true;
}

uint16_t get_tapping_term(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
        case LCTL_T(KC_ESC):
            return 0;
        case LT(1, KC_ENT):
            return 0;
        case LT(2, KC_TAB):
            return 0;
        default:
            return TAPPING_TERM;
    }
}

// const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
//     [0] = LAYOUT_split_3x6_3_ex2(
// //,-----------------------------------------------------.                    ,-----------------------------------------------------.
//      KC_TAB,    KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,  KC_LCTL,  KC_VOLU,     KC_Y,    KC_U,    KC_I,    KC_O,   KC_P,  KC_BSPC,
// //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
//      LCTL_T(KC_ESC),   KC_A,  KC_S,   KC_D,   KC_F,    KC_G,  KC_LALT,  KC_VOLD,     KC_H,   KC_J,   KC_K,   KC_L, KC_SCLN, KC_QUOT,
// //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
//     KC_UNDS,    KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,                         KC_N,    KC_M, KC_COMM,  KC_DOT, KC_SLSH,  KC_ENT,
// //|--------+--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------+--------|
//                                         KC_LGUI,   MO(1),  KC_SPC,     KC_RSFT,   MO(2), KC_RGUI
//                                     //`--------------------------'  `--------------------------'
//
//   ),
//     [1] = LAYOUT_split_3x6_3_ex2(
// //,-----------------------------------------------------.                    ,-----------------------------------------------------.
//      KC_TAB,    KC_1,    KC_2,    KC_3,    KC_4,    KC_5, KC_LCTL,    KC_BRIU,     KC_6,    KC_7,    KC_8,    KC_9,    KC_0, KC_BSPC,
// //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
//     LCTL_T(KC_ESC), KC_LSFT, KC_LALT, KC_LCTL, KC_LGUI, XXXXXXX,   KC_LALT,KC_BRID, KC_LEFT, KC_DOWN,   KC_UP,KC_RIGHT, XXXXXXX, XXXXXXX,
// //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
//     KC_LSFT, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                      XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
// //|--------+--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------+--------|
//                                         KC_LGUI, _______,  KC_SPC,     KC_RSFT,   MO(3), KC_RGUI
//                                     //`--------------------------'  `--------------------------'
//   ),
//
//     [2] = LAYOUT_split_3x6_3_ex2(
// //,-----------------------------------------------------.                    ,-----------------------------------------------------.
//      KC_TAB, KC_EXLM, S(KC_COMM), S(KC_DOT),  KC_DLR, KC_PERC, KC_LCTL,   KC_VOLU,  KC_CIRC, KC_AMPR, KC_ASTR, KC_LPRN, KC_RPRN, KC_BSPC,
// //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
//     LCTL_T(KC_ESC), KC_EXLM, KC_MINS, KC_PLUS, KC_EQL, KC_HASH, KC_LALT,    KC_VOLD,  XXXXXXX, KC_RGUI, KC_RCTL, KC_RALT, KC_RSFT, KC_GRV,
// //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
//     KC_LSFT, XXXXXXX, KC_SLSH, KC_ASTR, KC_BSLS, KC_TILD,                      XXXXXXX, KC_LBRC, KC_LCBR, KC_RCBR, KC_RBRC, KC_PIPE,
// //|--------+--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------+--------|
//                                         KC_LGUI,   MO(3),  KC_SPC,     KC_RSFT, _______, KC_RGUI
//                                     //`--------------------------'  `--------------------------'
//   ),
//
//     [3] = LAYOUT_split_3x6_3_ex2(
// //,-----------------------------------------------------.                    ,-----------------------------------------------------.
//     RM_TOGG, RM_HUED, RM_HUEU, RM_SATD, RM_SATU, RM_VALD, QK_BOOT,    KC_VOLU, RM_VALU, KC_MPRV, KC_MPLY, KC_MNXT, XXXXXXX, XXXXXXX,
// //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
// XXXXXXX,OSM(MOD_LSFT),OSM(MOD_LALT),OSM(MOD_LCTL),OSM(MOD_LGUI),OSM(MOD_HYPR),KC_LALT,KC_VOLD,OSM(MOD_HYPR),OSM(MOD_RGUI),OSM(MOD_RCTL),OSM(MOD_RALT),OSM(MOD_RSFT),XXXXXXX,
// //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
//     RM_NEXT, XXXXXXX, XXXXXXX, KC_BRID, KC_VOLD, KC_MUTE,                      XXXXXXX, KC_VOLU, KC_BRIU, XXXXXXX, XXXXXXX, XXXXXXX,
// //|--------+--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------+--------|
//                                         KC_LGUI, _______,  KC_SPC,     KC_RSFT, _______, KC_RGUI
//                                     //`--------------------------'  `--------------------------'
//   )
// };

// What if I didn't use the outer keys?
const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    [0] = LAYOUT_split_3x6_3_ex2(
//,-----------------------------------------------------.                    ,-----------------------------------------------------.
     XXXXXXX,    KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,  KC_LCTL,  KC_VOLU,     KC_Y,    KC_U,    KC_I,    KC_O,   KC_P,  XXXXXXX,
//|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
     LCTL_T(KC_ESC),   KC_A,  KC_S,   KC_D,   KC_F,    KC_G,  KC_LALT,  KC_VOLD,     KC_H,   KC_J,   KC_K,   KC_L, KC_SCLN, KC_QUOT,
//|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
    XXXXXXX,    KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,                         KC_N,    KC_M, KC_COMM,  KC_DOT, KC_SLSH,  XXXXXXX,
//|--------+--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------+--------|
                                        KC_LGUI,   LT(1, KC_ENT),  KC_SPC,     KC_RSFT, LT(2, KC_TAB), KC_RGUI
                                    //`--------------------------'  `--------------------------'

  ),
    [1] = LAYOUT_split_3x6_3_ex2(
//,-----------------------------------------------------.                    ,-----------------------------------------------------.
     XXXXXXX,    KC_1,    KC_2,    KC_3,    KC_4,    KC_5, KC_LCTL,    KC_BRIU,     KC_6,    KC_7,    KC_8,    KC_9,    KC_0, XXXXXXX,
//|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
    LCTL_T(KC_ESC), KC_LSFT, KC_LALT, KC_LCTL, KC_LGUI, XXXXXXX,   KC_LALT,KC_BRID, KC_LEFT, KC_DOWN,   KC_UP,KC_RIGHT, KC_BSPC, XXXXXXX,
//|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
    XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                      XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
//|--------+--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------+--------|
                                        KC_LGUI, _______,  KC_SPC,     KC_RSFT,   MO(3), KC_RGUI
                                    //`--------------------------'  `--------------------------'
  ),

    [2] = LAYOUT_split_3x6_3_ex2(
//,-----------------------------------------------------.                    ,-----------------------------------------------------.
    XXXXXXX, KC_PIPE, KC_LABK, KC_RABK,  KC_DLR, KC_PERC, KC_LCTL,   KC_VOLU,  KC_CIRC, KC_AMPR, KC_ASTR, KC_LPRN, KC_RPRN, XXXXXXX,
//|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
    LCTL_T(KC_ESC), KC_EXLM, KC_MINS, KC_PLUS, KC_EQL, KC_HASH, KC_LALT,    KC_VOLD,  XXXXXXX, KC_RGUI, KC_RCTL, KC_RALT, KC_RSFT, KC_GRV,
//|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
    XXXXXXX, XXXXXXX, KC_SLSH, KC_ASTR, KC_BSLS, KC_TILD,                      XXXXXXX, KC_LBRC, KC_LCBR, KC_RCBR, KC_RBRC, XXXXXXX,
//|--------+--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------+--------|
                                        KC_LGUI,   MO(3),  KC_SPC,     KC_RSFT, _______, KC_RGUI
                                    //`--------------------------'  `--------------------------'
  ),

    [3] = LAYOUT_split_3x6_3_ex2(
//,-----------------------------------------------------.                    ,-----------------------------------------------------.
    RM_TOGG, RM_HUED, RM_HUEU, RM_SATD, RM_SATU, RM_VALD, QK_BOOT,    KC_VOLU, RM_VALU, KC_MPRV, KC_MPLY, KC_MNXT, XXXXXXX, XXXXXXX,
//|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
XXXXXXX,OSM(MOD_LSFT),OSM(MOD_LALT),OSM(MOD_LCTL),OSM(MOD_LGUI),OSM(MOD_HYPR),KC_LALT,KC_VOLD,OSM(MOD_HYPR),OSM(MOD_RGUI),OSM(MOD_RCTL),OSM(MOD_RALT),OSM(MOD_RSFT),XXXXXXX,
//|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
    RM_NEXT, XXXXXXX, XXXXXXX, KC_BRID, KC_VOLD, KC_MUTE,                      XXXXXXX, KC_VOLU, KC_BRIU, XXXXXXX, XXXXXXX, XXXXXXX,
//|--------+--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------+--------|
                                        KC_LGUI, _______,  KC_SPC,     KC_RSFT, _______, KC_RGUI
                                    //`--------------------------'  `--------------------------'
  )
};

#ifdef ENCODER_MAP_ENABLE
const uint16_t PROGMEM encoder_map[][NUM_ENCODERS][NUM_DIRECTIONS] = {
  [0] = { ENCODER_CCW_CW(KC_VOLD, KC_VOLU), ENCODER_CCW_CW(KC_MPRV, KC_MNXT), ENCODER_CCW_CW(RM_VALD, RM_VALU), ENCODER_CCW_CW(KC_RGHT, KC_LEFT), },
  [1] = { ENCODER_CCW_CW(KC_VOLD, KC_VOLU), ENCODER_CCW_CW(KC_MPRV, KC_MNXT), ENCODER_CCW_CW(RM_VALD, RM_VALU), ENCODER_CCW_CW(KC_RGHT, KC_LEFT), },
  [2] = { ENCODER_CCW_CW(KC_VOLD, KC_VOLU), ENCODER_CCW_CW(KC_MPRV, KC_MNXT), ENCODER_CCW_CW(RM_VALD, RM_VALU), ENCODER_CCW_CW(KC_RGHT, KC_LEFT), },
  [3] = { ENCODER_CCW_CW(KC_VOLD, KC_VOLU), ENCODER_CCW_CW(KC_MPRV, KC_MNXT), ENCODER_CCW_CW(RM_VALD, RM_VALU), ENCODER_CCW_CW(KC_RGHT, KC_LEFT), },
};
#endif
