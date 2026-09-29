$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 20, 14, 8 mm, 85 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 15;                // step 1 length
d2 = 20;                  // step 2 diameter
len2 = 30;                // step 2 length
d3 = 14;                  // step 3 diameter
len3 = 15;                // step 3 length
d4 = 8;                   // step 4 diameter
len4 = 25;                // step 4 length
total = 85;               // overall length
chamfer = 1.5;            // end chamfer
cross_d = 5;              // cross pin hole
cross_z = 72.5;           // cross hole position

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [25 - chamfer, 0], [25, chamfer], [25, 15], [10, 15], [10, 45], [7, 45], [7, 60], [4, 60], [4, 83.5], [2.5, 85], [0, 85]];

difference() {
  rotate_extrude() polygon(profile);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d4 + 4, d = cross_d, center = true);
}
