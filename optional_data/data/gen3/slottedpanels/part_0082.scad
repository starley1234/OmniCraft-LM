$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 180 x 90 mm, 5 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 180;            // panel width
panel_d = 90;             // panel depth
thick = 6;                // panel thickness
slot_w = 6;               // slot width
pitch0 = 12;              // first row pitch
pitch_step = 1.2;         // pitch increase per row
margin = 12;              // margin around the slot field
rows = 5;                 // number of slot rows
mount_d = 6.6;            // mounting holes
mount_x = 75;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 12, length 156 */
  hull() {
    translate([12, 15, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([168, 15, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 13.2, length 156 */
  hull() {
    translate([12, 27, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([168, 27, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 12, length 156 */
  hull() {
    translate([12, 40.2, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([168, 40.2, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 13.2, length 156 */
  hull() {
    translate([12, 52.2, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([168, 52.2, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 12, length 156 */
  hull() {
    translate([12, 65.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([168, 65.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 6, -2.5]) cylinder(h = 11, d = mount_d);
  translate([15, 84, -2.5]) cylinder(h = 11, d = mount_d);
  translate([165, 6, -2.5]) cylinder(h = 11, d = mount_d);
  translate([165, 84, -2.5]) cylinder(h = 11, d = mount_d);
}
