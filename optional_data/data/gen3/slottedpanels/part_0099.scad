$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 120 x 80 mm, 4 ряда of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 120;            // panel width
panel_d = 80;             // panel depth
thick = 8;                // panel thickness
slot_w = 7;               // slot width
pitch0 = 11;              // first row pitch
pitch_step = 1.8;         // pitch increase per row
margin = 10;              // margin around the slot field
rows = 4;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 45;             // mounting hole offset
rim_h = 15;               // rim height
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
  /* row 0: pitch 11, length 70 */
  hull() {
    translate([25, 13.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([95, 13.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 12.8, length 75 */
  hull() {
    translate([22.5, 24.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([97.5, 24.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 14.6, length 80 */
  hull() {
    translate([20, 37.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([100, 37.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 16.4, length 85 */
  hull() {
    translate([17.5, 51.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([102.5, 51.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 5, -2.5]) cylinder(h = 20, d = mount_d);
  translate([15, 75, -2.5]) cylinder(h = 20, d = mount_d);
  translate([105, 5, -2.5]) cylinder(h = 20, d = mount_d);
  translate([105, 75, -2.5]) cylinder(h = 20, d = mount_d);
}
