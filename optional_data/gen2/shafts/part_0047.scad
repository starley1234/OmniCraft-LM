$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 20, 10 mm, 60 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 25;                // step 1 length
d2 = 20;                  // step 2 diameter
len2 = 15;                // step 2 length
d3 = 10;                  // step 3 diameter
len3 = 20;                // step 3 length
total = 60;               // overall length
chamfer = 2.5;            // end chamfer
cross_d = 6;              // cross pin hole
cross_z = 50;             // cross hole position

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [25 - chamfer, 0], [25, chamfer], [25, 25], [10, 25], [10, 40], [5, 40], [5, 57.5], [2.5, 60], [0, 60]];

difference() {
  rotate_extrude() polygon(profile);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d3 + 4, d = cross_d, center = true);
}
