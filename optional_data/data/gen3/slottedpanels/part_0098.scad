$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 150 x 100 mm, 7 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 150;            // panel width
panel_d = 100;            // panel depth
thick = 5;                // panel thickness
slot_w = 6;               // slot width
pitch0 = 10;              // first row pitch
pitch_step = 1.8;         // pitch increase per row
margin = 9.6;             // margin around the slot field
rows = 7;                 // number of slot rows
mount_d = 6.6;            // mounting holes
mount_x = 63;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 10, length 130.8 */
  hull() {
    translate([9.6, 12.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([140.4, 12.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 11.8, length 130.8 */
  hull() {
    translate([9.6, 22.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([140.4, 22.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 10, length 130.8 */
  hull() {
    translate([9.6, 34.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([140.4, 34.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 11.8, length 130.8 */
  hull() {
    translate([9.6, 44.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([140.4, 44.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 10, length 130.8 */
  hull() {
    translate([9.6, 56.2, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([140.4, 56.2, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 5: pitch 11.8, length 130.8 */
  hull() {
    translate([9.6, 66.2, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([140.4, 66.2, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 6: pitch 10, length 130.8 */
  hull() {
    translate([9.6, 78, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([140.4, 78, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 4.8, -2.5]) cylinder(h = 10, d = mount_d);
  translate([12, 95.2, -2.5]) cylinder(h = 10, d = mount_d);
  translate([138, 4.8, -2.5]) cylinder(h = 10, d = mount_d);
  translate([138, 95.2, -2.5]) cylinder(h = 10, d = mount_d);
}
