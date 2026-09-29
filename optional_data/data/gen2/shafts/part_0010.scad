$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 20, 14, 10 mm, 50 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 20;                  // step 1 diameter
len1 = 15;                // step 1 length
d2 = 14;                  // step 2 diameter
len2 = 15;                // step 2 length
d3 = 10;                  // step 3 diameter
len3 = 20;                // step 3 length
total = 50;               // overall length
chamfer = 1.5;            // end chamfer
groove_r = 5;             // groove radius
groove_z = 32;            // groove position from the end
groove_w = 3;             // groove width
groove_d = 1;             // groove depth
cross_d = 5;              // cross pin hole
cross_z = 7.5;            // cross hole position

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [10 - chamfer, 0], [10, chamfer], [10, 15], [7, 15], [7, 30], [5, 30], [5, 48.5], [3.5, 50], [0, 50]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d1 + 4, d = cross_d, center = true);
}
