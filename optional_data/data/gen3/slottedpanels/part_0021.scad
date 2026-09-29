$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 150 x 70 mm, 4 ряда of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 150;            // panel width
panel_d = 70;             // panel depth
thick = 6;                // panel thickness
slot_w = 6;               // slot width
pitch0 = 10;              // first row pitch
pitch_step = 2.4;         // pitch increase per row
margin = 12;              // margin around the slot field
rows = 4;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 63;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 10, length 126 */
  hull() {
    translate([12, 15, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([138, 15, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 12.4, length 126 */
  hull() {
    translate([12, 25, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([138, 25, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 10, length 126 */
  hull() {
    translate([12, 37.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([138, 37.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 12.4, length 126 */
  hull() {
    translate([12, 47.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([138, 47.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 6, -2.5]) cylinder(h = 11, d = mount_d);
  translate([12, 64, -2.5]) cylinder(h = 11, d = mount_d);
  translate([138, 6, -2.5]) cylinder(h = 11, d = mount_d);
  translate([138, 64, -2.5]) cylinder(h = 11, d = mount_d);
}
