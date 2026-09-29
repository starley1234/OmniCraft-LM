$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 150 x 100 mm, 5 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 150;            // panel width
panel_d = 100;            // panel depth
thick = 6;                // panel thickness
slot_w = 6;               // slot width
pitch0 = 12;              // first row pitch
pitch_step = 1.8;         // pitch increase per row
margin = 10;              // margin around the slot field
rows = 5;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 63;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 12, length 91 */
  hull() {
    translate([29.5, 13, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([120.5, 13, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 13.8, length 97.5 */
  hull() {
    translate([26.25, 25, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([123.75, 25, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 15.6, length 104 */
  hull() {
    translate([23, 38.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([127, 38.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 17.4, length 110.5 */
  hull() {
    translate([19.75, 54.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([130.25, 54.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 19.2, length 117 */
  hull() {
    translate([16.5, 71.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([133.5, 71.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 5, -2.5]) cylinder(h = 11, d = mount_d);
  translate([12, 95, -2.5]) cylinder(h = 11, d = mount_d);
  translate([138, 5, -2.5]) cylinder(h = 11, d = mount_d);
  translate([138, 95, -2.5]) cylinder(h = 11, d = mount_d);
}
