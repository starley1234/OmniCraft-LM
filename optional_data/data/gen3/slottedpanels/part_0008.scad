$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 180 x 100 mm, 6 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 180;            // panel width
panel_d = 100;            // panel depth
thick = 8;                // panel thickness
slot_w = 7;               // slot width
pitch0 = 12;              // first row pitch
pitch_step = 2.4;         // pitch increase per row
margin = 12;              // margin around the slot field
rows = 6;                 // number of slot rows
mount_d = 6.6;            // mounting holes
mount_x = 78;             // mounting hole offset
rim_h = 15;               // rim height
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
  /* row 0: pitch 12, length 62.4 */
  hull() {
    translate([58.8, 15.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([121.2, 15.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 12, length 81.12 */
  hull() {
    translate([49.44, 27.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([130.56, 27.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 12, length 99.84 */
  hull() {
    translate([40.08, 39.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([139.92, 39.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 12, length 118.56 */
  hull() {
    translate([30.72, 51.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([149.28, 51.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 12, length 137.28 */
  hull() {
    translate([21.36, 63.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([158.64, 63.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 5: pitch 12, length 156 */
  hull() {
    translate([12, 75.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([168, 75.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 6, -2.5]) cylinder(h = 20, d = mount_d);
  translate([12, 94, -2.5]) cylinder(h = 20, d = mount_d);
  translate([168, 6, -2.5]) cylinder(h = 20, d = mount_d);
  translate([168, 94, -2.5]) cylinder(h = 20, d = mount_d);
}
