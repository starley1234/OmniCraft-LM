$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 180 x 100 mm, 6 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 180;            // panel width
panel_d = 100;            // panel depth
thick = 6;                // panel thickness
slot_w = 7;               // slot width
pitch0 = 13;              // first row pitch
pitch_step = 1.2;         // pitch increase per row
margin = 10;              // margin around the slot field
rows = 6;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 78;             // mounting hole offset
rim_h = 13;               // rim height
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
  /* row 0: pitch 13, length 64 */
  hull() {
    translate([58, 13.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([122, 13.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 13, length 83.2 */
  hull() {
    translate([48.4, 26.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([131.6, 26.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 13, length 102.4 */
  hull() {
    translate([38.8, 39.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([141.2, 39.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 13, length 121.6 */
  hull() {
    translate([29.2, 52.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([150.8, 52.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 13, length 140.8 */
  hull() {
    translate([19.6, 65.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([160.4, 65.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 5: pitch 13, length 160 */
  hull() {
    translate([10, 78.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([170, 78.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 5, -2.5]) cylinder(h = 18, d = mount_d);
  translate([12, 95, -2.5]) cylinder(h = 18, d = mount_d);
  translate([168, 5, -2.5]) cylinder(h = 18, d = mount_d);
  translate([168, 95, -2.5]) cylinder(h = 18, d = mount_d);
}
