$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 120 x 80 mm, 5 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 120;            // panel width
panel_d = 80;             // panel depth
thick = 5;                // panel thickness
slot_w = 5;               // slot width
pitch0 = 9;               // first row pitch
pitch_step = 1.8;         // pitch increase per row
margin = 9.6;             // margin around the slot field
rows = 5;                 // number of slot rows
mount_d = 6.6;            // mounting holes
mount_x = 48;             // mounting hole offset
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
  /* row 0: pitch 9, length 70.56 */
  hull() {
    translate([24.72, 12.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([95.28, 12.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 10.8, length 75.6 */
  hull() {
    translate([22.2, 21.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([97.8, 21.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 12.6, length 80.64 */
  hull() {
    translate([19.68, 31.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([100.32, 31.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 14.4, length 85.68 */
  hull() {
    translate([17.16, 44.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([102.84, 44.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 16.2, length 90.72 */
  hull() {
    translate([14.64, 58.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([105.36, 58.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 4.8, -2.5]) cylinder(h = 15, d = mount_d);
  translate([12, 75.2, -2.5]) cylinder(h = 15, d = mount_d);
  translate([108, 4.8, -2.5]) cylinder(h = 15, d = mount_d);
  translate([108, 75.2, -2.5]) cylinder(h = 15, d = mount_d);
}
