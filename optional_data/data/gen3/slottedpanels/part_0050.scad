$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 180 x 90 mm, 4 ряда of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 180;            // panel width
panel_d = 90;             // panel depth
thick = 5;                // panel thickness
slot_w = 7;               // slot width
pitch0 = 13;              // first row pitch
pitch_step = 2.4;         // pitch increase per row
margin = 8.4;             // margin around the slot field
rows = 4;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 78;             // mounting hole offset
rim_h = 10;               // rim height
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
  /* row 0: pitch 13, length 114.24 */
  hull() {
    translate([32.88, 11.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([147.12, 11.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 15.4, length 122.4 */
  hull() {
    translate([28.8, 24.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([151.2, 24.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 17.8, length 130.56 */
  hull() {
    translate([24.72, 40.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([155.28, 40.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 20.2, length 138.72 */
  hull() {
    translate([20.64, 58.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([159.36, 58.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 4.2, -2.5]) cylinder(h = 15, d = mount_d);
  translate([12, 85.8, -2.5]) cylinder(h = 15, d = mount_d);
  translate([168, 4.2, -2.5]) cylinder(h = 15, d = mount_d);
  translate([168, 85.8, -2.5]) cylinder(h = 15, d = mount_d);
}
