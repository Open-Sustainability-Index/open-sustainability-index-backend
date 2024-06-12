export function toSlug(str: string): string {
  return str
    .trim()
    .toLowerCase()
    .replace(/ |_|\//g, '-'); // space/underscore/slash to dash
}
