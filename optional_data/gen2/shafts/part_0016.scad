$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 25, 10 mm, 40 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 15;                // step 1 length
d2 = 25;                  // step 2 diameter
len2 = 15;                // step 2 length
d3 = 10;                  // step 3 diameter
len3 = 10;                // step 3 length
total = 40;               // overall length
chamfer = 2;              // end chamfer
groove_r = 5;             // groove radius
groove_z = 32;            // groove position from the end
groove_w = 3.5;           // groove width
groove_d = 1;             // groove depth

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [20 - chamfer, 0], [20, chamfer], [20, 15], [12.5, 15], [12.5, 30], [5, 30], [5, 38], [3, 40], [0, 40]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
}
