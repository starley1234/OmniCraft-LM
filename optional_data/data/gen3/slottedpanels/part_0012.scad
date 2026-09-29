$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 180 x 80 mm, 4 ряда of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 180;            // panel width
panel_d = 80;             // panel depth
thick = 5;                // panel thickness
slot_w = 7;               // slot width
pitch0 = 13;              // first row pitch
pitch_step = 1.2;         // pitch increase per row
margin = 12;              // margin around the slot field
rows = 4;                 // number of slot rows
mount_d = 6.6;            // mounting holes
mount_x = 78;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 13, length 156 */
  hull() {
    translate([12, 15.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([168, 15.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 14.2, length 156 */
  hull() {
    translate([12, 28.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([168, 28.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 13, length 156 */
  hull() {
    translate([12, 42.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([168, 42.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 14.2, length 156 */
  hull() {
    translate([12, 55.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([168, 55.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 6, -2.5]) cylinder(h = 10, d = mount_d);
  translate([12, 74, -2.5]) cylinder(h = 10, d = mount_d);
  translate([168, 6, -2.5]) cylinder(h = 10, d = mount_d);
  translate([168, 74, -2.5]) cylinder(h = 10, d = mount_d);
}
