$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 200 x 70 mm, 4 ряда of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 200;            // panel width
panel_d = 70;             // panel depth
thick = 8;                // panel thickness
slot_w = 5;               // slot width
pitch0 = 10;              // first row pitch
pitch_step = 1.8;         // pitch increase per row
margin = 12;              // margin around the slot field
rows = 4;                 // number of slot rows
mount_d = 6.6;            // mounting holes
mount_x = 88;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 10, length 123.2 */
  hull() {
    translate([38.4, 14.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([161.6, 14.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 11.8, length 132 */
  hull() {
    translate([34, 24.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([166, 24.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 13.6, length 140.8 */
  hull() {
    translate([29.6, 36.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([170.4, 36.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 15.4, length 149.6 */
  hull() {
    translate([25.2, 49.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([174.8, 49.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 6, -2.5]) cylinder(h = 13, d = mount_d);
  translate([12, 64, -2.5]) cylinder(h = 13, d = mount_d);
  translate([188, 6, -2.5]) cylinder(h = 13, d = mount_d);
  translate([188, 64, -2.5]) cylinder(h = 13, d = mount_d);
}
