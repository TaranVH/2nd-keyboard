// https://geekhack.org/index.php?topic=69169.msg2781175#msg2781175


#include "unimap_trans.h"
#include "action_layer.h"


#define AC_FN0 ACTION_LAYER_MOMENTARY(1)

#ifdef KEYMAP_SECTION_ENABLE
const action_t actionmaps[][UNIMAP_ROWS][UNIMAP_COLS] __attribute__ ((section (".keymap.keymaps"))) = {
#else
const action_t actionmaps[][UNIMAP_ROWS][UNIMAP_COLS] PROGMEM = {
#endif
    UNIMAP(
              F13, F14, F15, F16, F17, F18, F19, F20, F21, F22, F23,  NO,
    ESC,      F1,  F2,  F3,  F4,  F5,  F6,  F7,  F8,  F9,  F10, F11, F12,           PSCR,SLCK,PCMM,         VOLD,VOLU,MUTE,
    GRV, 1,   2,   3,   4,   5,   6,   7,   8,   9,   0,   MINS,EQL, JYEN,BSPC,     INS, HOME,PGUP,    INT6,PSLS,PAST,PMNS,
    TAB, Q,   W,   E,   R,   T,   Y,   U,   I,   O,   P,   LBRC,RBRC,     BSLS,     DEL, END, PGDN,    P7,  P8,  P9,  PPLS,
    F20, A,   S,   D,   F,   G,   H,   J,   K,   L,   SCLN,QUOT,     NUHS,ENT,                         P4,  P5,  P6,  PCMM,
    INT2,NUBS,Z,   X,   C,   V,   B,   N,   M,   COMM,DOT, SLSH,     RO,  INT3,          UP,           P1,  P2,  P3,  PENT,
    LANG2,LANG1,INT1,MHEN,         SPC,        HENK,KANA,LANG4,LANG3,INT4,INT5,     LEFT,DOWN,RGHT,    P0,       PDOT,PEQL
    ),
    UNIMAP(
              TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,
    TRNS,     TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,          TRNS,TRNS,TRNS,         TRNS,TRNS,TRNS,
    TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,     TRNS,TRNS,TRNS,    TRNS,TRNS,TRNS,TRNS,
    TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,     TRNS,     TRNS,TRNS,TRNS,    TRNS,TRNS,TRNS,TRNS,
    TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,     TRNS,TRNS,                        TRNS,TRNS,TRNS,TRNS,
    TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,END, PGDN,DOWN,     TRNS,TRNS,          TRNS,         TRNS,TRNS,TRNS,TRNS,
    TRNS,TRNS,TRNS,TRNS,          TRNS,          TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,     TRNS,TRNS,TRNS,     TRNS,     TRNS,TRNS
    ),
};


bool hook_process_action(keyrecord_t *record) {
    static uint8_t f24_tracker;
    action_t action = layer_switch_get_action(record->event);

    switch (action.code) {
    case KC_A ... KC_F23: //notice how it skips over F24
    case KC_EXECUTE ... KC_EXSEL: //exsel is the last one before the modifier keys
        if (record->event.pressed) {
            register_code(KC_F24); //this means to send F24 down
            f24_tracker++;
            register_code(action.code);
        } else {
            unregister_code(action.code);
            f24_tracker--;
            if (!f24_tracker) {
                unregister_code(KC_F24); //this means to send F24 up
            }
            //real key is released HERE
        }
        return true;
        break;
    }
    return false;
}