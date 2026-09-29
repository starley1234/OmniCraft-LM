$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 200 x 70 mm, 4 ряда of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 200;            // panel width
panel_d = 70;             // panel depth
thick = 8;                // panel thickness
slot_w = 6;               // slot width
pitch0 = 10;              // first row pitch
pitch_step = 1.2;         // pitch increase per row
margin = 12;              // margin around the slot field
rows = 4;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 85;             // mounting hole offset
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
  /* row 0: pitch 10, length 123.2 */
  hull() {
    translate([38.4, 15, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([161.6, 15, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 11.2, length 132 */
  hull() {
    translate([34, 25, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([166, 25, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 12.4, length 140.8 */
  hull() {
    translate([29.6, 36.2, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([170.4, 36.2, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 13.6, length 149.6 */
  hull() {
    translate([25.2, 48.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([174.8, 48.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 6, -2.5]) cylinder(h = 18, d = mount_d);
  translate([15, 64, -2.5]) cylinder(h = 18, d = mount_d);
  translate([185, 6, -2.5]) cylinder(h = 18, d = mount_d);
  translate([185, 64, -2.5]) cylinder(h = 18, d = mount_d);
}
