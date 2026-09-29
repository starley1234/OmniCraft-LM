$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 120 x 70 mm, 4 ряда of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 120;            // panel width
panel_d = 70;             // panel depth
thick = 8;                // panel thickness
slot_w = 6;               // slot width
pitch0 = 10;              // first row pitch
pitch_step = 1.8;         // pitch increase per row
margin = 10;              // margin around the slot field
rows = 4;                 // number of slot rows
mount_d = 6.6;            // mounting holes
mount_x = 48;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 10, length 70 */
  hull() {
    translate([25, 13, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([95, 13, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 11.8, length 75 */
  hull() {
    translate([22.5, 23, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([97.5, 23, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 13.6, length 80 */
  hull() {
    translate([20, 34.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([100, 34.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 15.4, length 85 */
  hull() {
    translate([17.5, 48.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([102.5, 48.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 5, -2.5]) cylinder(h = 13, d = mount_d);
  translate([12, 65, -2.5]) cylinder(h = 13, d = mount_d);
  translate([108, 5, -2.5]) cylinder(h = 13, d = mount_d);
  translate([108, 65, -2.5]) cylinder(h = 13, d = mount_d);
}
