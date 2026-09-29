$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 120 x 70 mm, 4 ряда of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 120;            // panel width
panel_d = 70;             // panel depth
thick = 6;                // panel thickness
slot_w = 7;               // slot width
pitch0 = 12;              // first row pitch
pitch_step = 1.8;         // pitch increase per row
margin = 12;              // margin around the slot field
rows = 4;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 45;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 12, length 96 */
  hull() {
    translate([12, 15.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([108, 15.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 13.8, length 96 */
  hull() {
    translate([12, 27.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([108, 27.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 12, length 96 */
  hull() {
    translate([12, 41.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([108, 41.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 13.8, length 96 */
  hull() {
    translate([12, 53.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([108, 53.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 6, -2.5]) cylinder(h = 11, d = mount_d);
  translate([15, 64, -2.5]) cylinder(h = 11, d = mount_d);
  translate([105, 6, -2.5]) cylinder(h = 11, d = mount_d);
  translate([105, 64, -2.5]) cylinder(h = 11, d = mount_d);
}
