$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 120 x 80 mm, 6 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 120;            // panel width
panel_d = 80;             // panel depth
thick = 8;                // panel thickness
slot_w = 6;               // slot width
pitch0 = 10;              // first row pitch
pitch_step = 2.4;         // pitch increase per row
margin = 8.4;             // margin around the slot field
rows = 6;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 45;             // mounting hole offset
rim_h = 15;               // rim height
rim_t = 4;                // rim wall thickness

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
    translate([0, 0, thick - 1]) difference() {
      cube([panel_w, panel_d, rim_h - thick + 1]);
      translate([rim_t, rim_t, -2.5]) cube([panel_w - 2 * rim_t, panel_d - 2 * rim_t, rim_h - thick + 6]);
    }
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 10, length 41.28 */
  hull() {
    translate([39.36, 11.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([80.64, 11.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 10, length 53.66 */
  hull() {
    translate([33.17, 21.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([86.83, 21.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 10, length 66.05 */
  hull() {
    translate([26.98, 31.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([93.03, 31.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 10, length 78.43 */
  hull() {
    translate([20.78, 41.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([99.21, 41.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 10, length 90.82 */
  hull() {
    translate([14.59, 51.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([105.41, 51.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 5: pitch 10, length 103.2 */
  hull() {
    translate([8.4, 61.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([111.6, 61.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 4.2, -2.5]) cylinder(h = 20, d = mount_d);
  translate([15, 75.8, -2.5]) cylinder(h = 20, d = mount_d);
  translate([105, 4.2, -2.5]) cylinder(h = 20, d = mount_d);
  translate([105, 75.8, -2.5]) cylinder(h = 20, d = mount_d);
}
