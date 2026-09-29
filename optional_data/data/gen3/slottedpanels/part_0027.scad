$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 180 x 100 mm, 6 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 180;            // panel width
panel_d = 100;            // panel depth
thick = 6;                // panel thickness
slot_w = 6;               // slot width
pitch0 = 10;              // first row pitch
pitch_step = 2.4;         // pitch increase per row
margin = 8.4;             // margin around the slot field
rows = 6;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 75;             // mounting hole offset
rim_h = 11;               // rim height
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
  /* row 0: pitch 10, length 114.24 */
  hull() {
    translate([32.88, 11.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([147.12, 11.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 12.4, length 122.4 */
  hull() {
    translate([28.8, 21.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([151.2, 21.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 14.8, length 130.56 */
  hull() {
    translate([24.72, 33.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([155.28, 33.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 17.2, length 138.72 */
  hull() {
    translate([20.64, 48.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([159.36, 48.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 19.6, length 146.88 */
  hull() {
    translate([16.56, 65.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([163.44, 65.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 5: pitch 22, length 146.88 */
  hull() {
    translate([16.56, 85.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([163.44, 85.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 4.2, -2.5]) cylinder(h = 16, d = mount_d);
  translate([15, 95.8, -2.5]) cylinder(h = 16, d = mount_d);
  translate([165, 4.2, -2.5]) cylinder(h = 16, d = mount_d);
  translate([165, 95.8, -2.5]) cylinder(h = 16, d = mount_d);
}
