# figset

**figset**, and its friend **figrow**, are [Hugo](https://gohugo.io/) [shortcodes](https://gohugo.io/content-management/shortcodes/) 
for adding images to webpages.

The difference from the standard **figure** shortcode is that **figset** uses HTML's <code>srcset</code>
attribute to provide optimised images for the user's screen.

Hugo's built-in image processing facilities are used to create the <code>srcset</code> images. 

**figrow** helps with organising images into galleries.

**figset** can use [lightboxSSA](https://github.com/StarsoftAnalysis/lightboxSSA) to create a light box or 
carousel-type gallery out of some or all of the images on a page.

There is also a **figgallery** shortcode (and partial), which builds a figrow from all the 
images found in the pages resources.

## More details

Images are sized...   adjusted to have the same area

Images are either in the page's resources, or remote or (TODO elsewhere on the site???)

Uses flexbox...


## Demo Site

A demonstration site showing examples of the features of figset and lightboxSSA is at:

* [figsetdemo])https://starsoftanalysis.github.io/figsetdemo/gallery/)

## Sample Sites

These sites use `figset` extensively:

* [Plotting Shed Art](https://plottingshed.art/)
* [Avon Valley Shed](https://avonvalleyshed.org.uk/)

## Installation

module or theme...

You need to invoke the figset CSS somehow.  Either include
```
@import "figset.scss";
```
in your site's SCSS, or put this in HTML's `<head>`:
```
<link rel="stylesheet" href="/css/figset.css" type="text/css">
```

or use the provided `figset_loader.html` partial template to include
the CSS on pages where figset is marked as active.  See 'Options' somewhere here.

## Using figset

```
{{<figset name="pic1.png" caption="The first picture" alt="Descriptive text">}}
```

#### active

Whether or not to include the figset stylesheet on this page (if in the frontmatter) or on 
every page (if in the configuration).

FIXME this is not an option to use in a shortcode or partial, just in the params.

#### name

The name of the image.  It can be a resource belonging to the page, that will be retrieved via Hugo's .Resources.GetMatch function.

example: `name="fred.png"`

This parameter is required for the figset shortcode, but can be replaced by the image parameter if the figset partial is called from another template.

#### image

The image resource to use.  This parameter can only be used when using the figset partial, not the shortcode, when the resource is already known, rather than just its name. 

example: ```
  {{ $image = .Page.Resources.GetMatch "fred.png" }}
  {{ partial figset (dict  "site" .Site  "page" .Page  "figrow" true  "image" $image) }} ```

#### position

This parameter applies a class to the figure which affects its horizontal position.

* `left`, `l` -- moves the figure to the left
* `start`, `s` -- moves the figure the start side (left for LTR text, right for RTL text)
* `right`, `r` -- moves the figure to the right
* `end`, `e` -- moves the figure to the end side (right for LTR text, left for RTL text)
* `center`, `centre`, `c` -- moves the figure to the centre

If the position is not specified, the figure takes the next position in the standard HTML flow.

example: `position=c`
default: `(none)`

#### size

Specify one of `thumbnail`, `small`, `medium`, `large`, `full`.

Sizes are relative.  What?  Is there a standard area for each size?  Does it depend on screen size?

example: `size=med`
default: ?

#### maxwidth

The biggest image size, in pixels, to use.  This size will not be exceeded even if the `size` parameter would use a bigger size,
and also limits the size of the linked image with `url=self`.

example: `maxwidth=800`
default: ??

#### selfsize

This or maxwidth -- which is use!?!?

#### title

Title text which shows up as the tooltip for the image.

example: `title="Puppy"`
default?

#### caption

Text that will be displayed below the image using the `figcaption` HTML element.

example: `Bonzo the puppy`
default: ?

#### alt

Text that describes the contents of the image, for use when the image can't be loaded or can't be seen by the user.

example: `alt="A black labrador pup looks up at the camera"`

#### url

The URL to link to when the user clicks on the image.  If the image has the lightbox or gallery features, the URL will be used on the second click if galleried.  The special value 'self' can be used to link to a full-sized version of the image.  For a remote image (i.e. the `name` parameter starts with `http[s]://`), the link will be to that remote image rather than to a local copy.

If no `url` is given, the image will not be clickable (unless it uses the lightbox feature).

example: `url="https://www.example.com/labradors"` 

#### gallery

A short name for the gallery that is used with the lightbox to enable transitions between images.  The gallery name is only used
internally, and is not seen by the user.  Typically, all the images on the page, or perhaps all the images within a `figrow` 
should have the same gallery name.

Any value given for gallery switches on the lightbox mechanism, i.e., `gallery` implies `lightbox`.

example: `gallery=g1`
default: no gallery

#### lightbox  

Set to true to add the lightbox effect to this image without making it part of a gallery.

example: `lightbox=true`
default: `false`

#### sameheight

really?

#### sharpen

Set to true to add a mild sharpening effect, using Hugo's [unsharpmask](https://gohugo.io/functions/images/unsharpmask/) function, with values "10 0.5 0.03".

example: `sharpen=true`
default: `false`

#### debug

Set to true to output debugging information as warnings when Hugo is run; also overlays resized images with size information.

example: `debug=true`
default: `false`

#### figrow

Set this to true if the `figset` is within a `figrow`.  This is set automatically when using shortcodes, but needs to be set explicitly when using partials (see below).
example: `figset=true`
default: `false`

## Summary of figset parameters

Note that text parameter values must be quoted if they contain spaces or other special characters.  For example, name=pic1.png, name="Picture One.png".
True/false values and numbers do not need to be quoted.  (true/false --- what will they do if quited?)

TODO keep the table simple -- details above only

| Parameter  | Type       | Default | Description |
| ---------- | ---------- | ------- | ----------- |
| name       | text       | (none)  | The filename of an image within the page bundle; or the URL of a remote image. |
| image      | resource   | (none)  | The image to use; this image overrides name. |
| position   | left/start, right/end, centre/center | ?? | horizontal position of the figure |
| size       | thumb, small, medium, large, full | ? | Err... |
| maxwidth   | pixels     | ??      | biggest size used for srcset in pixels, or for url=self |
| selfsize   | pixels     | ??      | max size in px of url=self image |
| title      | text       | (none)  | Shows as a tool-tip |
| caption    | text       | (none)  | Forms the figcaption in the HTML. |
| alt        | text       | (none)  | Alternative text for the image. |
| url        | text       | (none)  | The URL to link to when the user clicks on the image. |
| gallery    | text       | (none)  | The name of the gallery that this image is part of. |
| lightbox   | true/false | false   | Use a lightbox for this image. |
| sameheight | true/false | false   | Set to true to make all images with the same `size` value the same height.  Does this work? FIXME |
| sharpen    | true/false | false   | True to apply a mild unsharp mask filter. |
| class1     | text       | (none)  | Classes from parent figrow to be applied to the figure HTML element. |
| class2     | text       | (none)  | Classes specific to this figset to be applied to the figure HTML element. |
| capclass   | text       | (none)  | Classes for the figcaption HTML element. |
| id         | text       | (none)  | An HTML id for this figset. |
| debug      | true/false | false   | Set to true to output debugging information. |
| figrow     | true/false |         | Set this to true if the figset is within a figrow.



## Styling

The module provides `figset.scss` and also a pre-compiled `figset.css`, which can 
be integrated into you Hugo site.

Use the class1, class2, and id parameters.
to override the classes from figset.scss.

## Partials

To use figset and figrow from another template or partial, rather than via shortcodes from content,
you can use the figset and figrow partials.

The parameters are the same, but the way defaults are applied is different because there is no concept
of partials being nested as shortcodes can be.

Parameters get passed in as a dict, starting with the current site and page contexts.
e.g. {{ partial figset (dict  "site 
simple figset examplt

TODO: more complex example with figrow -- have to do your own iterating, can't put defaults in the figrow
  DON'T FORGET!!
  * figset needs the site and page context to be passed in, 
  * when using figrow_start partial from another template:
    - put 'figrow true' in the figset partial's dict, otherwise the figcaptions get all narrow -- still don't know why exactly.

## Other notes

Remote images: don't forget that Hugo sites are static -- the image will be as retrieved when the site is built, and won't
change if the source changes until the site is rebuilt.

## Troubleshooting

* If the captions are wonky when using partials, make sure the `figrow` parameter is correctly set.

## To do

* Get rid of LightboxSSA -- it's not part of this module, it's a recommendation
* assets/images and static/images -- why are they not all in the same place?   where should they go in the user's structure?
* overwrite placeholder with name of missing image
* clear=both for figrow (don't pass it to figset)

* DONE? either use bootstrap consistently, or not at all -- i.e. remove the dependency.  bs is good for sizing etc.(?)
* lightboxSSA needs images in assets|static/images -- can that be fixed? 

### Stages

* get the layout and sizing right
  * what if figsets have position left/right within a row?
    - I think float is ignored within a flex-container -- we'll use the .figrow flag to not float within flex.
* lightbox
* links to big images or elsewhere, with or without gallery
* all the srcset stuff
* make captions fit
* DONE move CSS to a separate file to get merged into the rest -- to make for easier tuning of CSS aspects.
* how to module-ise the head stuff e.g. including lightboxssa where needed etc.
   - and maybe only use figset.scss where needed.

### FIXME

* position default to top -- annoys figrow

### Done

* decide about param names and values e.g. valign=left or align-contents=flex-start ?  -- custom ones
* shortcodes/partials/options -- what about namespacing?  parent?
* but might want some styling options.
-- see partials/figset.html for more history
* add site-wide options e.g. for unsharp 
