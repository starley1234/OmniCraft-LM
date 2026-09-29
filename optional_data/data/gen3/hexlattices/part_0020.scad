$fn = 32;

// ----------------------------------------------------------------------
// Honeycomb panel: 90.15 x 42.57 mm, 21 cells of 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 90.15;          // panel width
panel_d = 42.57;          // panel depth
thick = 5;                // panel thickness
cell_r = 5;               // hex cell circumradius
pitch = 10.26;            // hex cell pitch (centre to centre)
web = 1.6;                // web between the cells
columns = 7;              // columns of cells
rows = 3;                 // rows of cells
cell_count = 21;          // total cells
shift_x = 11.73;          // first cell offset in x
shift_y = 12.4;           // first cell offset in y
mount_d = 4.4;            // corner mounting holes
hole_off = 3.7;           // mounting hole offset from the corners

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
  translate([3.7, 3.7, -2.5]) cylinder(h = thick + 5, d = mount_d);
  translate([86.45, 3.7, -2.5]) cylinder(h = thick + 5, d = mount_d);
  translate([3.7, 38.87, -2.5]) cylinder(h = thick + 5, d = mount_d);
  translate([86.45, 38.87, -2.5]) cylinder(h = thick + 5, d = mount_d);
}
