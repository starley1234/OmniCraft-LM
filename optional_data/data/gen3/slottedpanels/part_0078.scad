$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 200 x 70 mm, 4 ряда of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 200;            // panel width
panel_d = 70;             // panel depth
thick = 5;                // panel thickness
slot_w = 7;               // slot width
pitch0 = 12;              // first row pitch
pitch_step = 1.8;         // pitch increase per row
margin = 10;              // margin around the slot field
rows = 4;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 85;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 12, length 72 */
  hull() {
    translate([64, 13.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([136, 13.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 12, length 93.6 */
  hull() {
    translate([53.2, 25.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([146.8, 25.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 12, length 115.2 */
  hull() {
    translate([42.4, 37.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([157.6, 37.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 12, length 136.8 */
  hull() {
    translate([31.6, 49.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([168.4, 49.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 5, -2.5]) cylinder(h = 10, d = mount_d);
  translate([15, 65, -2.5]) cylinder(h = 10, d = mount_d);
  translate([185, 5, -2.5]) cylinder(h = 10, d = mount_d);
  translate([185, 65, -2.5]) cylinder(h = 10, d = mount_d);
}
