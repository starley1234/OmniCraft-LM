$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 120 x 90 mm, 6 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 120;            // panel width
panel_d = 90;             // panel depth
thick = 8;                // panel thickness
slot_w = 6;               // slot width
pitch0 = 11;              // first row pitch
pitch_step = 2.4;         // pitch increase per row
margin = 10;              // margin around the slot field
rows = 6;                 // number of slot rows
mount_d = 6.6;            // mounting holes
mount_x = 45;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 11, length 40 */
  hull() {
    translate([40, 13, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([80, 13, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 11, length 52 */
  hull() {
    translate([34, 24, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([86, 24, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 11, length 64 */
  hull() {
    translate([28, 35, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([92, 35, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 11, length 76 */
  hull() {
    translate([22, 46, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([98, 46, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 11, length 88 */
  hull() {
    translate([16, 57, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([104, 57, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 5: pitch 11, length 100 */
  hull() {
    translate([10, 68, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([110, 68, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 5, -2.5]) cylinder(h = 13, d = mount_d);
  translate([15, 85, -2.5]) cylinder(h = 13, d = mount_d);
  translate([105, 5, -2.5]) cylinder(h = 13, d = mount_d);
  translate([105, 85, -2.5]) cylinder(h = 13, d = mount_d);
}
