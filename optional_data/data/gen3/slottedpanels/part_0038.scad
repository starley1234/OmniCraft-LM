$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 180 x 80 mm, 5 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 180;            // panel width
panel_d = 80;             // panel depth
thick = 5;                // panel thickness
slot_w = 5;               // slot width
pitch0 = 10;              // first row pitch
pitch_step = 2.4;         // pitch increase per row
margin = 9.6;             // margin around the slot field
rows = 5;                 // number of slot rows
mount_d = 6.6;            // mounting holes
mount_x = 75;             // mounting hole offset
rim_h = 10;               // rim height
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
  /* row 0: pitch 10, length 112.56 */
  hull() {
    translate([33.72, 12.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([146.28, 12.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 12.4, length 120.6 */
  hull() {
    translate([29.7, 22.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([150.3, 22.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 14.8, length 128.64 */
  hull() {
    translate([25.68, 34.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([154.32, 34.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 17.2, length 136.68 */
  hull() {
    translate([21.66, 49.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([158.34, 49.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 19.6, length 144.72 */
  hull() {
    translate([17.64, 66.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([162.36, 66.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 4.8, -2.5]) cylinder(h = 15, d = mount_d);
  translate([15, 75.2, -2.5]) cylinder(h = 15, d = mount_d);
  translate([165, 4.8, -2.5]) cylinder(h = 15, d = mount_d);
  translate([165, 75.2, -2.5]) cylinder(h = 15, d = mount_d);
}
