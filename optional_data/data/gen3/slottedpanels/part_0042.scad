$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 120 x 70 mm, 5 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 120;            // panel width
panel_d = 70;             // panel depth
thick = 8;                // panel thickness
slot_w = 6;               // slot width
pitch0 = 11;              // first row pitch
pitch_step = 1.8;         // pitch increase per row
margin = 9.6;             // margin around the slot field
rows = 5;                 // number of slot rows
mount_d = 6.6;            // mounting holes
mount_x = 48;             // mounting hole offset
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
  /* row 0: pitch 11, length 40.32 */
  hull() {
    translate([39.84, 12.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([80.16, 12.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 11, length 52.42 */
  hull() {
    translate([33.79, 23.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([86.21, 23.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 11, length 64.51 */
  hull() {
    translate([27.74, 34.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([92.25, 34.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 11, length 76.61 */
  hull() {
    translate([21.7, 45.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([98.31, 45.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 11, length 88.7 */
  hull() {
    translate([15.65, 56.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([104.35, 56.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 4.8, -2.5]) cylinder(h = 18, d = mount_d);
  translate([12, 65.2, -2.5]) cylinder(h = 18, d = mount_d);
  translate([108, 4.8, -2.5]) cylinder(h = 18, d = mount_d);
  translate([108, 65.2, -2.5]) cylinder(h = 18, d = mount_d);
}
