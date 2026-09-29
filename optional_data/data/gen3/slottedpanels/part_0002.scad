$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 180 x 90 mm, 5 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 180;            // panel width
panel_d = 90;             // panel depth
thick = 5;                // panel thickness
slot_w = 6;               // slot width
pitch0 = 12;              // first row pitch
pitch_step = 1.8;         // pitch increase per row
margin = 12;              // margin around the slot field
rows = 5;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 78;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 12, length 109.2 */
  hull() {
    translate([35.4, 15, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([144.6, 15, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 13.8, length 117 */
  hull() {
    translate([31.5, 27, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([148.5, 27, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 15.6, length 124.8 */
  hull() {
    translate([27.6, 40.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([152.4, 40.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 17.4, length 132.6 */
  hull() {
    translate([23.7, 56.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([156.3, 56.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 19.2, length 140.4 */
  hull() {
    translate([19.8, 73.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([160.2, 73.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 6, -2.5]) cylinder(h = 10, d = mount_d);
  translate([12, 84, -2.5]) cylinder(h = 10, d = mount_d);
  translate([168, 6, -2.5]) cylinder(h = 10, d = mount_d);
  translate([168, 84, -2.5]) cylinder(h = 10, d = mount_d);
}
