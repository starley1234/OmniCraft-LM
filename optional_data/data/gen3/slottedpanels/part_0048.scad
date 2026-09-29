$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 120 x 70 mm, 4 ряда of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 120;            // panel width
panel_d = 70;             // panel depth
thick = 6;                // panel thickness
slot_w = 5;               // slot width
pitch0 = 10;              // first row pitch
pitch_step = 1.2;         // pitch increase per row
margin = 10;              // margin around the slot field
rows = 4;                 // number of slot rows
mount_d = 6.6;            // mounting holes
mount_x = 48;             // mounting hole offset
rim_h = 13;               // rim height
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
  /* row 0: pitch 10, length 70 */
  hull() {
    translate([25, 12.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([95, 12.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 11.2, length 75 */
  hull() {
    translate([22.5, 22.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([97.5, 22.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 12.4, length 80 */
  hull() {
    translate([20, 33.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([100, 33.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 13.6, length 85 */
  hull() {
    translate([17.5, 46.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([102.5, 46.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 5, -2.5]) cylinder(h = 18, d = mount_d);
  translate([12, 65, -2.5]) cylinder(h = 18, d = mount_d);
  translate([108, 5, -2.5]) cylinder(h = 18, d = mount_d);
  translate([108, 65, -2.5]) cylinder(h = 18, d = mount_d);
}
