$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 120 x 80 mm, 4 ряда of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 120;            // panel width
panel_d = 80;             // panel depth
thick = 8;                // panel thickness
slot_w = 7;               // slot width
pitch0 = 13;              // first row pitch
pitch_step = 2.4;         // pitch increase per row
margin = 12;              // margin around the slot field
rows = 4;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 45;             // mounting hole offset
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
  /* row 0: pitch 13, length 67.2 */
  hull() {
    translate([26.4, 15.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([93.6, 15.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 15.4, length 72 */
  hull() {
    translate([24, 28.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([96, 28.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 17.8, length 76.8 */
  hull() {
    translate([21.6, 43.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([98.4, 43.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 20.2, length 81.6 */
  hull() {
    translate([19.2, 61.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([100.8, 61.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 6, -2.5]) cylinder(h = 18, d = mount_d);
  translate([15, 74, -2.5]) cylinder(h = 18, d = mount_d);
  translate([105, 6, -2.5]) cylinder(h = 18, d = mount_d);
  translate([105, 74, -2.5]) cylinder(h = 18, d = mount_d);
}
