$fn = 32;

// ----------------------------------------------------------------------
// Honeycomb panel: 112.91 x 77.29 mm, 48 cells of 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 112.91;         // panel width
panel_d = 77.29;          // panel depth
thick = 5;                // panel thickness
cell_r = 5;               // hex cell circumradius
pitch = 11.66;            // hex cell pitch (centre to centre)
web = 3;                  // web between the cells
columns = 8;              // columns of cells
rows = 6;                 // rows of cells
cell_count = 48;          // total cells
shift_x = 12.73;          // first cell offset in x
shift_y = 13.4;           // first cell offset in y
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
  translate([108.71, 4.2, -2.5]) cylinder(h = thick + 5, d = mount_d);
  translate([4.2, 73.09, -2.5]) cylinder(h = thick + 5, d = mount_d);
  translate([108.71, 73.09, -2.5]) cylinder(h = thick + 5, d = mount_d);
}
