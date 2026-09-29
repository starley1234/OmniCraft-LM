$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 25, 14, 12, 8 mm, 60 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 25;                  // step 1 diameter
len1 = 10;                // step 1 length
d2 = 14;                  // step 2 diameter
len2 = 15;                // step 2 length
d3 = 12;                  // step 3 diameter
len3 = 25;                // step 3 length
d4 = 8;                   // step 4 diameter
len4 = 10;                // step 4 length
total = 60;               // overall length
chamfer = 2;              // end chamfer
groove_r = 4;             // groove radius
groove_z = 52;            // groove position from the end
groove_w = 3.5;           // groove width
groove_d = 1;             // groove depth
cross_d = 5;              // cross pin hole
cross_z = 5;              // cross hole position

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [12.5 - chamfer, 0], [12.5, chamfer], [12.5, 10], [7, 10], [7, 25], [6, 25], [6, 50], [4, 50], [4, 58], [2, 60], [0, 60]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d1 + 4, d = cross_d, center = true);
}
