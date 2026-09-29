$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 200 x 70 mm, 4 ряда of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 200;            // panel width
panel_d = 70;             // panel depth
thick = 5;                // panel thickness
slot_w = 7;               // slot width
pitch0 = 11;              // first row pitch
pitch_step = 1.2;         // pitch increase per row
margin = 10;              // margin around the slot field
rows = 4;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 88;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 11, length 126 */
  hull() {
    translate([37, 13.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([163, 13.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 12.2, length 135 */
  hull() {
    translate([32.5, 24.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([167.5, 24.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 13.4, length 144 */
  hull() {
    translate([28, 36.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([172, 36.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 14.6, length 153 */
  hull() {
    translate([23.5, 50.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([176.5, 50.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 5, -2.5]) cylinder(h = 10, d = mount_d);
  translate([12, 65, -2.5]) cylinder(h = 10, d = mount_d);
  translate([188, 5, -2.5]) cylinder(h = 10, d = mount_d);
  translate([188, 65, -2.5]) cylinder(h = 10, d = mount_d);
}
