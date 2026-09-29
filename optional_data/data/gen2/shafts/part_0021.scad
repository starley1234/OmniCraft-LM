$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 25, 20, 8 mm, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 25;                  // step 1 diameter
len1 = 15;                // step 1 length
d2 = 20;                  // step 2 diameter
len2 = 25;                // step 2 length
d3 = 8;                   // step 3 diameter
len3 = 40;                // step 3 length
total = 80;               // overall length
chamfer = 1.5;            // end chamfer
groove_r = 10;            // groove radius
groove_z = 17;            // groove position from the end
groove_w = 3;             // groove width
groove_d = 1.3;           // groove depth

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [12.5 - chamfer, 0], [12.5, chamfer], [12.5, 15], [10, 15], [10, 40], [4, 40], [4, 78.5], [2.5, 80], [0, 80]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
}
