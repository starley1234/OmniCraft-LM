$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 200 x 80 mm, 4 ряда of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 200;            // panel width
panel_d = 80;             // panel depth
thick = 5;                // panel thickness
slot_w = 7;               // slot width
pitch0 = 11;              // first row pitch
pitch_step = 1.8;         // pitch increase per row
margin = 9.6;             // margin around the slot field
rows = 4;                 // number of slot rows
mount_d = 6.6;            // mounting holes
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
  /* row 0: pitch 11, length 126.56 */
  hull() {
    translate([36.72, 13.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([163.28, 13.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 12.8, length 135.6 */
  hull() {
    translate([32.2, 24.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([167.8, 24.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 14.6, length 144.64 */
  hull() {
    translate([27.68, 36.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([172.32, 36.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 16.4, length 153.68 */
  hull() {
    translate([23.16, 51.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([176.84, 51.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 4.8, -2.5]) cylinder(h = 17, d = mount_d);
  translate([15, 75.2, -2.5]) cylinder(h = 17, d = mount_d);
  translate([185, 4.8, -2.5]) cylinder(h = 17, d = mount_d);
  translate([185, 75.2, -2.5]) cylinder(h = 17, d = mount_d);
}
