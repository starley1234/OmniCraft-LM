$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 120 x 80 mm, 4 ряда of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 120;            // panel width
panel_d = 80;             // panel depth
thick = 8;                // panel thickness
slot_w = 7;               // slot width
pitch0 = 12;              // first row pitch
pitch_step = 1.8;         // pitch increase per row
margin = 9.6;             // margin around the slot field
rows = 4;                 // number of slot rows
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
  /* row 0: pitch 12, length 70.56 */
  hull() {
    translate([24.72, 13.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([95.28, 13.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 13.8, length 75.6 */
  hull() {
    translate([22.2, 25.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([97.8, 25.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 15.6, length 80.64 */
  hull() {
    translate([19.68, 38.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([100.32, 38.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 17.4, length 85.68 */
  hull() {
    translate([17.16, 54.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([102.84, 54.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 4.8, -2.5]) cylinder(h = 18, d = mount_d);
  translate([12, 75.2, -2.5]) cylinder(h = 18, d = mount_d);
  translate([108, 4.8, -2.5]) cylinder(h = 18, d = mount_d);
  translate([108, 75.2, -2.5]) cylinder(h = 18, d = mount_d);
}
