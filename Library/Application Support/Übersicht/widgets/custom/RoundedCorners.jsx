// This is a simple example Widget to get you started with Übersicht.
// For the full documentation please visit:
// https://github.com/felixhageloh/uebersicht

// You can modify this widget as you see fit, or simply delete this file to
// remove it.

// this is the shell command that gets executed every time this widget refreshes
export const command = "echo 1";

// the refresh frequency in milliseconds
export const refreshFrequency = 1000000;

const cornerSize = '11px';
const borderWidth = '2px';
const barHeight = '36px'

// the CSS style for this widget, written using Emotion
// https://emotion.sh/
export const className =`
  /*background: black;*/
  bottom: 0;
  color: white;
  left: 0;
  right: 0;
  top: 0;
  z-index: -1;

  .border {
    border: ${borderWidth} solid black;
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    top: 0;
  }

  .bar {
    background: black;
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: ${barHeight};
  }

  .corner {
    background: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAoCAYAAACM/rhtAAABBElEQVR42s3VgYYCURhH8RIIEgSxJKBFD7AAArAPEcDu0ovsYhc9RTCAQI+xgAiQAK6C7h74wyLAzIkD996++TFmpsevdtiZ9vRD77SiBU1oSIO2gYUa2tCS+rXW3qPaAN7pQGsa/Qd0CbzSluYPER0AC33RNBcxARuaZbgJeKTXDLUBdzTOQBPwRh8ZZANe6CVDbMATPWeADfhLT/mzDXgKzgi85LYagbc8EEpgXiVW4C4HjcAjjbXAfFutwCYHjMBCMzPwM5tG4JWmZuA2G0bgneZm4CGLVuDaDCw0MgObLFiBGztwaQaeqW8G7q24AL/twDc7cGUHLuzAiR04tAMHZuAf1UqKFksYePoAAAAASUVORK5CYII=);
    background-size: contain;
    background-repeat: no-repeat;
    position: absolute;
    width: ${cornerSize};
    height: ${cornerSize};
  }

  .top.left.corner {
    top: ${barHeight};
    left: ${borderWidth};
  }

  .top.right.corner {
    top: ${barHeight};
    right: ${borderWidth};
    transform: rotate(90deg);
  }

  .bottom.left.corner {
    bottom: ${borderWidth};
    left: ${borderWidth};
    transform: rotate(270deg);
  }

  .bottom.right.corner {
    bottom: ${borderWidth};
    right: ${borderWidth};
    transform: rotate(180deg);
  }
`

// render gets called after the shell command has executed. The command's output
// is passed in as a string.
export const render = ({output}) => {
  return (
    <div>
      <i className="border" />
      <i className="bar" />
      <i className="top left corner" />
      <i className="top right corner" />
      <i className="bottom left corner" />
      <i className="bottom right corner" />
    </div>
  );
}

