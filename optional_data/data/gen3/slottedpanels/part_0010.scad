$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 120 x 70 mm, 4 ряда of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 120;            // panel width
panel_d = 70;             // panel depth
thick = 6;                // panel thickness
slot_w = 7;               // slot width
pitch0 = 12;              // first row pitch
pitch_step = 1.2;         // pitch increase per row
margin = 8.4;             // margin around the slot field
rows = 4;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 48;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 12, length 103.2 */
  hull() {
    translate([8.4, 11.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([111.6, 11.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 13.2, length 103.2 */
  hull() {
    translate([8.4, 23.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([111.6, 23.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 12, length 103.2 */
  hull() {
    translate([8.4, 37.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([111.6, 37.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 13.2, length 103.2 */
  hull() {
    translate([8.4, 49.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([111.6, 49.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 4.2, -2.5]) cylinder(h = 11, d = mount_d);
  translate([12, 65.8, -2.5]) cylinder(h = 11, d = mount_d);
  translate([108, 4.2, -2.5]) cylinder(h = 11, d = mount_d);
  translate([108, 65.8, -2.5]) cylinder(h = 11, d = mount_d);
}
