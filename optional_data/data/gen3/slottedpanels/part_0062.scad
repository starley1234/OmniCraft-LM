$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 120 x 80 mm, 4 ряда of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 120;            // panel width
panel_d = 80;             // panel depth
thick = 6;                // panel thickness
slot_w = 6;               // slot width
pitch0 = 11;              // first row pitch
pitch_step = 1.2;         // pitch increase per row
margin = 12;              // margin around the slot field
rows = 4;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 45;             // mounting hole offset
rim_h = 11;               // rim height
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
  /* row 0: pitch 11, length 67.2 */
  hull() {
    translate([26.4, 15, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([93.6, 15, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 12.2, length 72 */
  hull() {
    translate([24, 26, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([96, 26, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 13.4, length 76.8 */
  hull() {
    translate([21.6, 38.2, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([98.4, 38.2, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 14.6, length 81.6 */
  hull() {
    translate([19.2, 51.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([100.8, 51.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 6, -2.5]) cylinder(h = 16, d = mount_d);
  translate([15, 74, -2.5]) cylinder(h = 16, d = mount_d);
  translate([105, 6, -2.5]) cylinder(h = 16, d = mount_d);
  translate([105, 74, -2.5]) cylinder(h = 16, d = mount_d);
}
