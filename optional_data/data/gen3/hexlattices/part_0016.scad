$fn = 32;

// ----------------------------------------------------------------------
// Honeycomb panel: 96.98 x 70.09 mm, 20 cells of 14 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 96.98;          // panel width
panel_d = 70.09;          // panel depth
thick = 5;                // panel thickness
cell_r = 7;               // hex cell circumradius
pitch = 15.12;            // hex cell pitch (centre to centre)
web = 3;                  // web between the cells
columns = 5;              // columns of cells
rows = 4;                 // rows of cells
cell_count = 20;          // total cells
shift_x = 14.46;          // first cell offset in x
shift_y = 15.4;           // first cell offset in y
mount_d = 5.4;            // corner mounting holes
hole_off = 4.2;           // mounting hole offset from the corners

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* hexagonal cells, point-up, cut right through the plate */
  for (row = [0 : rows - 1]) {
    for (col = [0 : columns - 1]) {
      translate([shift_x + col * pitch + (row % 2) * pitch / 2, shift_y + row * pitch * 0.866025, -2.5]) rotate([0, 0, 30]) cylinder(h = thick + 5, d = 2 * cell_r, $fn = 6);
    }
  }
  /* corner mounting holes, clear of the outer cell web */
  translate([4.2, 4.2, -2.5]) cylinder(h = thick + 5, d = mount_d);
  translate([92.78, 4.2, -2.5]) cylinder(h = thick + 5, d = mount_d);
  translate([4.2, 65.89, -2.5]) cylinder(h = thick + 5, d = mount_d);
  translate([92.78, 65.89, -2.5]) cylinder(h = thick + 5, d = mount_d);
}
