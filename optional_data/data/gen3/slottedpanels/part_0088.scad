$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 180 x 80 mm, 4 ряда of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 180;            // panel width
panel_d = 80;             // panel depth
thick = 8;                // panel thickness
slot_w = 7;               // slot width
pitch0 = 11;              // first row pitch
pitch_step = 1.8;         // pitch increase per row
margin = 12;              // margin around the slot field
rows = 4;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 78;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 11, length 109.2 */
  hull() {
    translate([35.4, 15.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([144.6, 15.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 12.8, length 117 */
  hull() {
    translate([31.5, 26.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([148.5, 26.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 14.6, length 124.8 */
  hull() {
    translate([27.6, 39.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([152.4, 39.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 16.4, length 132.6 */
  hull() {
    translate([23.7, 53.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([156.3, 53.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 6, -2.5]) cylinder(h = 13, d = mount_d);
  translate([12, 74, -2.5]) cylinder(h = 13, d = mount_d);
  translate([168, 6, -2.5]) cylinder(h = 13, d = mount_d);
  translate([168, 74, -2.5]) cylinder(h = 13, d = mount_d);
}
