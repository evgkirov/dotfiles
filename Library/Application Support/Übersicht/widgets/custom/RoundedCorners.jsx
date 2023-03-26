// This is a simple example Widget to get you started with Übersicht.
// For the full documentation please visit:
// https://github.com/felixhageloh/uebersicht

// You can modify this widget as you see fit, or simply delete this file to
// remove it.

// this is the shell command that gets executed every time this widget refreshes
export const command = "echo 1";

// the refresh frequency in milliseconds
export const refreshFrequency = 1000000;

const color = '#000';
const cornerSize = '12px';
const borderWidth = '0px';
const barHeight = '45px'

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
    border: ${borderWidth} solid ${color};
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    top: 0;
  }

  .bar {
    background: ${color};
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: ${barHeight};
  }

  .corner {
    background-image: url("data:image/svg+xml,%3Csvg width='50' height='50' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath style='fill:%23000;fill-rule:evenodd;fill-opacity:1' d='M0 0v50A50 50 0 0 1 50 0H0z' /%3E%3C/svg%3E");    background-size: contain;
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

