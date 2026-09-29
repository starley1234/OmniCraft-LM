$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 180 x 90 mm, 5 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 180;            // panel width
panel_d = 90;             // panel depth
thick = 5;                // panel thickness
slot_w = 7;               // slot width
pitch0 = 11;              // first row pitch
pitch_step = 2.4;         // pitch increase per row
margin = 10;              // margin around the slot field
rows = 5;                 // number of slot rows
mount_d = 5.4;            // mounting holes
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
  /* row 0: pitch 11, length 112 */
  hull() {
    translate([34, 13.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([146, 13.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 13.4, length 120 */
  hull() {
    translate([30, 24.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([150, 24.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 15.8, length 128 */
  hull() {
    translate([26, 37.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([154, 37.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 18.2, length 136 */
  hull() {
    translate([22, 53.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([158, 53.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 20.6, length 144 */
  hull() {
    translate([18, 71.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([162, 71.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 5, -2.5]) cylinder(h = 15, d = mount_d);
  translate([15, 85, -2.5]) cylinder(h = 15, d = mount_d);
  translate([165, 5, -2.5]) cylinder(h = 15, d = mount_d);
  translate([165, 85, -2.5]) cylinder(h = 15, d = mount_d);
}
