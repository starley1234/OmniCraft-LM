$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 200 x 80 mm, 6 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 200;            // panel width
panel_d = 80;             // panel depth
thick = 6;                // panel thickness
slot_w = 5;               // slot width
pitch0 = 9;               // first row pitch
pitch_step = 2.4;         // pitch increase per row
margin = 12;              // margin around the slot field
rows = 6;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 85;             // mounting hole offset
rim_h = 13;               // rim height
rim_t = 3;                // rim wall thickness

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
    translate([0, 0, thick - 1]) difference() {
      cube([panel_w, panel_d, rim_h - thick + 1]);
      translate([rim_t, rim_t, -2.5]) cube([panel_w - 2 * rim_t, panel_d - 2 * rim_t, rim_h - thick + 6]);
    }
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 9, length 70.4 */
  hull() {
    translate([64.8, 14.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([135.2, 14.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 9, length 91.52 */
  hull() {
    translate([54.24, 23.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([145.76, 23.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 9, length 112.64 */
  hull() {
    translate([43.68, 32.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([156.32, 32.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 9, length 133.76 */
  hull() {
    translate([33.12, 41.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([166.88, 41.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 9, length 154.88 */
  hull() {
    translate([22.56, 50.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([177.44, 50.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 5: pitch 9, length 176 */
  hull() {
    translate([12, 59.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([188, 59.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 6, -2.5]) cylinder(h = 18, d = mount_d);
  translate([15, 74, -2.5]) cylinder(h = 18, d = mount_d);
  translate([185, 6, -2.5]) cylinder(h = 18, d = mount_d);
  translate([185, 74, -2.5]) cylinder(h = 18, d = mount_d);
}
