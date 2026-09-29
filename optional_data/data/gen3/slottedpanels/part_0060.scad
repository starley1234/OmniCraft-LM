$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 120 x 70 mm, 4 ряда of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 120;            // panel width
panel_d = 70;             // panel depth
thick = 6;                // panel thickness
slot_w = 7;               // slot width
pitch0 = 11;              // first row pitch
pitch_step = 2.4;         // pitch increase per row
margin = 9.6;             // margin around the slot field
rows = 4;                 // number of slot rows
mount_d = 6.6;            // mounting holes
mount_x = 48;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 11, length 70.56 */
  hull() {
    translate([24.72, 13.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([95.28, 13.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 13.4, length 75.6 */
  hull() {
    translate([22.2, 24.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([97.8, 24.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 15.8, length 80.64 */
  hull() {
    translate([19.68, 37.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([100.32, 37.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 18.2, length 85.68 */
  hull() {
    translate([17.16, 53.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([102.84, 53.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 4.8, -2.5]) cylinder(h = 11, d = mount_d);
  translate([12, 65.2, -2.5]) cylinder(h = 11, d = mount_d);
  translate([108, 4.8, -2.5]) cylinder(h = 11, d = mount_d);
  translate([108, 65.2, -2.5]) cylinder(h = 11, d = mount_d);
}
