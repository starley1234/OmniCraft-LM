$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 200 x 80 mm, 6 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 200;            // panel width
panel_d = 80;             // panel depth
thick = 8;                // panel thickness
slot_w = 6;               // slot width
pitch0 = 11;              // first row pitch
pitch_step = 2.4;         // pitch increase per row
margin = 8.4;             // margin around the slot field
rows = 6;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 85;             // mounting hole offset
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
  /* row 0: pitch 11, length 73.28 */
  hull() {
    translate([63.36, 11.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([136.64, 11.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 11, length 95.26 */
  hull() {
    translate([52.37, 22.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([147.63, 22.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 11, length 117.25 */
  hull() {
    translate([41.38, 33.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([158.63, 33.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 11, length 139.23 */
  hull() {
    translate([30.39, 44.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([169.62, 44.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 11, length 161.22 */
  hull() {
    translate([19.39, 55.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([180.61, 55.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 5: pitch 11, length 183.2 */
  hull() {
    translate([8.4, 66.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([191.6, 66.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 4.2, -2.5]) cylinder(h = 20, d = mount_d);
  translate([15, 75.8, -2.5]) cylinder(h = 20, d = mount_d);
  translate([185, 4.2, -2.5]) cylinder(h = 20, d = mount_d);
  translate([185, 75.8, -2.5]) cylinder(h = 20, d = mount_d);
}
