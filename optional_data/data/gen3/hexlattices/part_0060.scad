$fn = 32;

// ----------------------------------------------------------------------
// Honeycomb panel: 89.65 x 76.59 mm, 16 cells of 16 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 89.65;          // panel width
panel_d = 76.59;          // panel depth
thick = 8;                // panel thickness
cell_r = 8;               // hex cell circumradius
pitch = 16.86;            // hex cell pitch (centre to centre)
web = 3;                  // web between the cells
columns = 4;              // columns of cells
rows = 4;                 // rows of cells
cell_count = 16;          // total cells
shift_x = 15.33;          // first cell offset in x
shift_y = 16.4;           // first cell offset in y
mount_d = 5.4;            // corner mounting holes
hole_off = 4.2;           // mounting hole offset from the corners
rim_h = 14;               // rim height
rim_t = 5;                // rim wall thickness

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
    /* rim around the panel, sunk 1 mm into the plate */
    translate([0, 0, thick - 1]) difference() {
      cube([panel_w, panel_d, rim_h - thick + 1]);
      translate([rim_t, rim_t, -2.5]) cube([panel_w - 2 * rim_t, panel_d - 2 * rim_t, rim_h - thick + 6]);
    }
  }
  /* hexagonal cells, point-up, cut right through the plate */
  for (row = [0 : rows - 1]) {
    for (col = [0 : columns - 1]) {
      translate([shift_x + col * pitch + (row % 2) * pitch / 2, shift_y + row * pitch * 0.866025, -2.5]) rotate([0, 0, 30]) cylinder(h = thick + 5, d = 2 * cell_r, $fn = 6);
    }
  }
  /* corner mounting holes, clear of the outer cell web */
  translate([4.2, 4.2, -2.5]) cylinder(h = thick + 5, d = mount_d);
  translate([85.45, 4.2, -2.5]) cylinder(h = thick + 5, d = mount_d);
  translate([4.2, 72.39, -2.5]) cylinder(h = thick + 5, d = mount_d);
  translate([85.45, 72.39, -2.5]) cylinder(h = thick + 5, d = mount_d);
}
