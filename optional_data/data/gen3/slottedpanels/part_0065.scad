$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 200 x 90 mm, 6 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 200;            // panel width
panel_d = 90;             // panel depth
thick = 5;                // panel thickness
slot_w = 7;               // slot width
pitch0 = 13;              // first row pitch
pitch_step = 2.4;         // pitch increase per row
margin = 8.4;             // margin around the slot field
rows = 6;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 85;             // mounting hole offset
rim_h = 12;               // rim height
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
  /* row 0: pitch 13, length 73.28 */
  hull() {
    translate([63.36, 11.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([136.64, 11.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 13, length 95.26 */
  hull() {
    translate([52.37, 24.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([147.63, 24.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 13, length 117.25 */
  hull() {
    translate([41.38, 37.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([158.63, 37.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 13, length 139.23 */
  hull() {
    translate([30.39, 50.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([169.62, 50.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 13, length 161.22 */
  hull() {
    translate([19.39, 63.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([180.61, 63.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 5: pitch 13, length 183.2 */
  hull() {
    translate([8.4, 76.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([191.6, 76.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 4.2, -2.5]) cylinder(h = 17, d = mount_d);
  translate([15, 85.8, -2.5]) cylinder(h = 17, d = mount_d);
  translate([185, 4.2, -2.5]) cylinder(h = 17, d = mount_d);
  translate([185, 85.8, -2.5]) cylinder(h = 17, d = mount_d);
}
