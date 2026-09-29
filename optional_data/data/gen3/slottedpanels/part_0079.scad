$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 200 x 80 mm, 4 ряда of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 200;            // panel width
panel_d = 80;             // panel depth
thick = 5;                // panel thickness
slot_w = 6;               // slot width
pitch0 = 12;              // first row pitch
pitch_step = 1.8;         // pitch increase per row
margin = 12;              // margin around the slot field
rows = 4;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 88;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 12, length 176 */
  hull() {
    translate([12, 15, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([188, 15, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 13.8, length 176 */
  hull() {
    translate([12, 27, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([188, 27, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 12, length 176 */
  hull() {
    translate([12, 40.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([188, 40.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 13.8, length 176 */
  hull() {
    translate([12, 52.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([188, 52.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 6, -2.5]) cylinder(h = 10, d = mount_d);
  translate([12, 74, -2.5]) cylinder(h = 10, d = mount_d);
  translate([188, 6, -2.5]) cylinder(h = 10, d = mount_d);
  translate([188, 74, -2.5]) cylinder(h = 10, d = mount_d);
}
