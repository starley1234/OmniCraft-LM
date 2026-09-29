$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 200 x 70 mm, 4 ряда of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 200;            // panel width
panel_d = 70;             // panel depth
thick = 6;                // panel thickness
slot_w = 7;               // slot width
pitch0 = 11;              // first row pitch
pitch_step = 1.2;         // pitch increase per row
margin = 12;              // margin around the slot field
rows = 4;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 85;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 11, length 176 */
  hull() {
    translate([12, 15.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([188, 15.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 12.2, length 176 */
  hull() {
    translate([12, 26.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([188, 26.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 11, length 176 */
  hull() {
    translate([12, 38.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([188, 38.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 12.2, length 176 */
  hull() {
    translate([12, 49.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([188, 49.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 6, -2.5]) cylinder(h = 11, d = mount_d);
  translate([15, 64, -2.5]) cylinder(h = 11, d = mount_d);
  translate([185, 6, -2.5]) cylinder(h = 11, d = mount_d);
  translate([185, 64, -2.5]) cylinder(h = 11, d = mount_d);
}
