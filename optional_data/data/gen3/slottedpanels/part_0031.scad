$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 200 x 70 mm, 4 ряда of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 200;            // panel width
panel_d = 70;             // panel depth
thick = 5;                // panel thickness
slot_w = 7;               // slot width
pitch0 = 13;              // first row pitch
pitch_step = 1.8;         // pitch increase per row
margin = 8.4;             // margin around the slot field
rows = 4;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 88;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 13, length 183.2 */
  hull() {
    translate([8.4, 11.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([191.6, 11.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 14.8, length 183.2 */
  hull() {
    translate([8.4, 24.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([191.6, 24.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 13, length 183.2 */
  hull() {
    translate([8.4, 39.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([191.6, 39.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 14.8, length 183.2 */
  hull() {
    translate([8.4, 52.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([191.6, 52.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 4.2, -2.5]) cylinder(h = 10, d = mount_d);
  translate([12, 65.8, -2.5]) cylinder(h = 10, d = mount_d);
  translate([188, 4.2, -2.5]) cylinder(h = 10, d = mount_d);
  translate([188, 65.8, -2.5]) cylinder(h = 10, d = mount_d);
}
