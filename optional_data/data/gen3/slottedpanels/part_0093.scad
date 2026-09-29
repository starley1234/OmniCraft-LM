$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 150 x 70 mm, 3 ряда of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 150;            // panel width
panel_d = 70;             // panel depth
thick = 5;                // panel thickness
slot_w = 7;               // slot width
pitch0 = 13;              // first row pitch
pitch_step = 2.4;         // pitch increase per row
margin = 12;              // margin around the slot field
rows = 3;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 63;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 13, length 126 */
  hull() {
    translate([12, 15.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([138, 15.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 15.4, length 126 */
  hull() {
    translate([12, 28.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([138, 28.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 13, length 126 */
  hull() {
    translate([12, 43.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([138, 43.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 6, -2.5]) cylinder(h = 10, d = mount_d);
  translate([12, 64, -2.5]) cylinder(h = 10, d = mount_d);
  translate([138, 6, -2.5]) cylinder(h = 10, d = mount_d);
  translate([138, 64, -2.5]) cylinder(h = 10, d = mount_d);
}
